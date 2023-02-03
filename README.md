**Watch this video to learn how to fill this template
below:** https://www.youtube.com/watch?v=m63oH2RUvjc

**Any new Flutter Project ideas
needed?** [Choose Project Idea From This List](https://docs.google.com/document/d/1e42zZoIfJZyCBzrTzxv28fSsN0KFrMN6SDzDVBM67tc/edit?usp=sharing)

## 1. Research: Project Title

- Keywords:
    - video trimmer flutter
    - flutter video trimmer
    - flutter video editor
    - flutter video editing
    - video editor flutter github
    - video trimmer flutter github
    - flutter video format converter
    - flutter video player
    - video compress flutter
    - flutter video filters
    - flutter video player example
    - flutter ffmpeg video editor and text watermark to video
    - video editor using ffmpeg

- Video Title: Flutter video trimmer, video player - how to edit, format in ffmpeg or trim video in
  flutter

## 2. Research: Competitors

**Flutter Videos/Articles**

- https://pub.dev/packages/video_trimmer
- https://medium.com/flutter-community/my-journey-building-a-video-trimmer-package-for-flutter-73cd82997a7f
- https://img.ly/blog/how-to-crop-and-trim-videos-in-flutter/
- https://morioh.com/p/2da0c9660c74
- https://morioh.com/p/2d9ebef8ae7e
- https://morioh.com/p/9ab79cc7832c
- 1.6K: https://www.youtube.com/watch?v=3vuvEEMjUws

**Android/Swift/React Videos**

- https://www.youtube.com/watch?v=BzG_zZmvmgEW
- https://www.youtube.com/watch?v=efq3pxSLjlo&list=PLF0BIlN2vd8sm-ll3j16vEM3hNgbFLg1O

**Great Features**

- A Flutter package for trimming videos. This supports retrieving, trimming, and storage of trimmed
  video files to the file system.
- Customizable video trimmer.
- Supports two types of trim viewer, fixed length and scrollable.
- Video playback control.
- Retrieving and storing video file.
- Find more great features
  on [https://medium.com/flutter-community/my-journey-building-a-video-trimmer-package-for-flutter-73cd82997a7f](https://medium.com/flutter-community/my-journey-building-a-video-trimmer-package-for-flutter-73cd82997a7f)

**Problems from Videos**

- NA

**Problems from Flutter Stackoverflow**

- https://stackoverflow.com/questions/61482475/video-editor-on-flutter

## 3. Video Structure

**Main Points / Purpose Of Lesson**

1. In daily life, users want to trim in either fixed or scrollable type. They want video playback
   control, retrieving and storing video file. Video trimmer package provides us all these
   functionalities.
    1. Run `dart pub add video_trimmer` in terminal to add this package in pubspec.yaml file.
    2. Run `dart pub add file_picker` in terminal to input video from files.
    3. Android configuration No additional configuration is needed for using on Android platform.
       You are good to go!
    4. iOS configuration
        - Add the following keys to your Info.plist file, located
          in `<project root>/ios/Runner/Info.plist`:
          ```objectivec
             <key>NSCameraUsageDescription</key>
             <string>Used to demonstrate image picker plugin</string>
             <key>NSMicrophoneUsageDescription</key>
             <string>Used to capture audio for image picker plugin</string>
             <key>NSPhotoLibraryUsageDescription</key>
             <string>Used to demonstrate image picker plugin</string>
          ```
        - Set the platform version in ios/Podfile to 10.
          `platform :ios, '10'`

**The Structured Main Content**

1. In `home_page.dart`, we will pick video from files and it will load in `trimmer_view.dart`
   . `trimmer_view.dart` is the main screen of this package, we mainly use `VideoViewer`
   and `TrimViewer` in it. When user click on save video, video is saved as trimmed in trimmer view
   and path is shown on snackbar. `preview.dart` plays the saved video which has been trimmed just
   now.
2. `home_page.dart` picks a file/video from file manager using `file_picker` package and pass this
   as argument to `trimmer_view.dart`.
    ```dart
           appBar: AppBar(
          title: const Text("Video Trimmer"),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text("LOAD VIDEO"),
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.video,
                allowCompression: false,
              );
              if (result != null) {
                File file = File(result.files.single.path!);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TrimmerView(file)),
                );
              }
            },
          ),
    ```
3. `trimmer_view.dart`
    - Loads input video file.
      ```dart
      final Trimmer _trimmer = Trimmer();
      await _trimmer.loadVideo(videoFile: file);
      ```
    - VideoViewer
      ```dart
      VideoViewer(trimmer: _trimmer);
      ```
    - TrimViewer
      ````dart
      TrimViewer(
                        trimmer: _trimmer,
                        viewerHeight: 50.0,
                        viewerWidth: MediaQuery
                            .of(context)
                            .size
                            .width,
                        durationStyle: DurationStyle.FORMAT_MM_SS,
                        // maxVideoLength: const Duration(seconds: 10),
                        maxVideoLength: Duration(seconds: _trimmer.videoPlayerController!.value.duration.inSeconds),
                        editorProperties: TrimEditorProperties(
                          borderPaintColor: Colors.yellow,
                          borderWidth: 4,
                          borderRadius: 5,
                          circlePaintColor: Colors.yellow.shade800,
                        ),
                        areaProperties: TrimAreaProperties.edgeBlur(
                          thumbnailQuality: 10,
                        ),
                        onChangeStart: (value) => _startValue = value,
                        onChangeEnd: (value) => _endValue = value,
                        onChangePlaybackState: (value) =>
                            setState(() => _isPlaying = value),
                      ),
       ```
    - Save trimmed video
      ```dart
       _saveVideo() {
        setState(() {
        _progressVisibility = true;
        });
      _trimmer.saveTrimmedVideo(
      startValue: _startValue,
      endValue: _endValue,

      onSave: (outputPath) {
        setState(() {
          _progressVisibility = false;
        });

        debugPrint('OUTPUT PATH: $outputPath');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Preview(outputPath),
          ),
        );
      },
   ); }
      ```
    - Video playback state
      ```dart
      await _trimmer.videoPlaybackControl(
                        startValue: _startValue,
                        endValue: _endValue,
                      );
      ```
    - You can use an advanced FFmpeg command if you require more customization. Just define your
      FFmpeg command using the `ffmpegCommand` property and set an output video format
      using `customVideoFormat`.
4. `preview.dart` plays the video which is trimmed and saved in files of phone.
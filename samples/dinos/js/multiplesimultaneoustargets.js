var World = {
    loaded: false,
    dinoSettings: {
        diplodocus: {
            scale: 0.4
        },
        spinosaurus: {
            scale: 0.004
        },
        triceratops: {
            scale: 0.4
        },
        tyrannosaurus: {
            scale: 0.4
        }
    },

    init: function initFn() {
        this.createOverlays();
    },

    createOverlays: function createOverlaysFn() {
        this.targetCollectionResource = new AR.TargetCollectionResource("assets/dinosaurs.wtc", {
            onError: World.onError
        });
        this.tracker = new AR.ImageTracker(this.targetCollectionResource, {
            maximumNumberOfConcurrentlyTrackableTargets: 5,
            extendedRangeRecognition: AR.CONST.IMAGE_RECOGNITION_RANGE_EXTENSION.OFF,
            onTargetsLoaded: World.showInfoBar,
            onError: World.onError
        });

        /*
            Pre-load models such that they are available in cache to avoid any slowdown upon first recognition.
         */
        new AR.Model("assets/models/diplodocus.wt3");
        new AR.Model("assets/models/spinosaurus.wt3");
        new AR.Model("assets/models/triceratops.wt3");
        new AR.Model("assets/models/tyrannosaurus.wt3");

        /*
            Note that this time we use "*" as target name. That means that the AR.ImageTrackable will respond to
            any target that is defined in the target collection. You can use wildcards to specify more complex name
            matchings. E.g. 'target_?' to reference 'target_1' through 'target_9' or 'target*' for any targets
            names that start with 'target'.
         */
        this.dinoTrackable = new AR.ImageTrackable(this.tracker, "*", {
            onImageRecognized: function(target) {
                /*
                    Create 3D model based on which target was recognized.
                 */
                var model = new AR.Model("assets/models/" + target.name + ".wt3", {
                    scale: World.dinoSettings[target.name].scale,
                    rotate: {
                        z: 180
                    },
                    onError: World.onError
                });

                /* Adds the model as augmentation for the currently recognized target. */
                this.addImageTargetCamDrawables(target, model);

                World.hideInfoBar();
            },
            onError: World.onError
        });
    },

    onError: function onErrorFn(error) {
        alert(error);
    },

    hideInfoBar: function hideInfoBarFn() {
        document.getElementById("infoBox").style.display = "none";
    },

    showInfoBar: function worldLoadedFn() {
        document.getElementById("infoBox").style.display = "table";
        document.getElementById("loadingMessage").style.display = "none";
    }
};

World.init();
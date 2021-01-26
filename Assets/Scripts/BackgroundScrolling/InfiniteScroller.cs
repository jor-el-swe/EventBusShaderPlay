using UnityEngine;

namespace BackgroundScrolling{
    public class InfiniteScroller : MonoBehaviour{
        private Transform thisTransform;
        private Transform playerTransform;
        private float startPositionZ;
    
        // Start is called before the first frame update
        void Start(){
            thisTransform = transform;
            playerTransform = FindObjectOfType<PlayerController>().transform;
            startPositionZ = playerTransform.position.z;
        }

        // Update is called once per frame
        void FixedUpdate()
        {
            if (playerTransform.position.z > thisTransform.position.z){
                thisTransform.position = 
                    new Vector3(thisTransform.position.x, thisTransform.position.y, thisTransform.position.z + (playerTransform.position.z-startPositionZ));
                startPositionZ = playerTransform.position.z;
            }
        }
    }
}

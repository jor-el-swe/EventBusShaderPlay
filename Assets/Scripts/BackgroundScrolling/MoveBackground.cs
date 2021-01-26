
using UnityEngine;

public class MoveBackground : MonoBehaviour
{
    // Start is called before the first frame update
    private Vector3 offset;
    private Transform playerTransform;
    void Start(){
        playerTransform = FindObjectOfType<PlayerController>().transform;
        offset = playerTransform.position - transform.position;

    }

    // Update is called once per frame
    void FixedUpdate(){
        transform.position = playerTransform.position - offset;
    }
}

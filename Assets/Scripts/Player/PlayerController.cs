using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public float playerSpeed = 5f;

    // Update is called once per frame
    void Update()
    {
        transform.position += new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical")) * (playerSpeed * Time.deltaTime);
        
    }
}

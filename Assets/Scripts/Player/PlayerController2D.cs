using UnityEngine;

public class PlayerController2D: MonoBehaviour
{
    public float playerSpeed = 5f;
    // Update is called once per frame
    void Update()
    {
        transform.position += new Vector3(Input.GetAxis("Horizontal")*playerSpeed*Time.deltaTime, Input.GetAxis("Vertical") * playerSpeed*Time.deltaTime, 0.0f);
    }
}

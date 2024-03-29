const inner_width: f32 = {%inner_width%};
const inner_height: f32 = {%inner_height%};
const click_position: vec2<f32> = {%click_position%};

const PI = 3.14159265358979323846264338327;

@fragment
fn fragment_main(vs_out: VertexOut) -> @location(0) vec4<f32> {
  // provide (x,y) in pixels, center is (0,0)
  let pos = vs_out.pos;
  let x = pos.x * inner_width * 0.5;
  let y = pos.y * inner_height * 0.5;

  let dx = x - click_position.x;
  let dy = y - click_position.y;
  let angle = atan2(dy, dx);

  // draw a circle
  let l = length(vec2<f32>(dx, dy));
  let d = fract(angle / PI * 2.);
  if l < 40. * (1. - pow(0.25 - pow(0.5 - d, 2.), 0.2)) {
    return vec4(1.0, 1.0, 0.0, 1.0);
  }

  return vec4(vs_out.color, 1.0);
}

struct VertexOut {
  // default position
  @builtin(position) position: vec4<f32>,
  // position from -1 to 1
  @location(1) pos: vec3<f32>,
  // defined vertex color
  @location(0) color: vec3<f32>,
};

///
/// (-1, 1,0) (1, 1,0)
///
/// (-1,-1,0) (1,-1,0)
///
@vertex
fn vertex_main(
  @location(0) in_pos: vec3<f32>,
  @location(1) in_color: vec3<f32>
) -> VertexOut {
  var ret: VertexOut;
  ret.position = vec4<f32>(in_pos, 1.0);
  ret.color = in_color;
  ret.pos = in_pos;
  return ret;
}

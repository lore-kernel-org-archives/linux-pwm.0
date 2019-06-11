From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: pwm-backlight: Add 'max-brightness'
 property
Date: Tue, 11 Jun 2019 15:11:47 -0700
Message-ID: <20190611221147.GG137143@google.com>
References: <20190610233739.29477-1-mka@chromium.org>
 <00220cd7-ed4b-5250-d448-cf83ed4c2012@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00220cd7-ed4b-5250-d448-cf83ed4c2012@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pwm@vger.kernel.org

Hi Jacek,

On Tue, Jun 11, 2019 at 10:02:23PM +0200, Jacek Anaszewski wrote:
> Hi Matthias,
> 
> On 6/11/19 1:37 AM, Matthias Kaehlcke wrote:
> > Add an optional 'max-brightness' property, which is used to specify
> > the number of brightness levels (max-brightness + 1) when the node
> > has no 'brightness-levels' table.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >   .../devicetree/bindings/leds/backlight/pwm-backlight.txt       | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > index 64fa2fbd98c9..98f4ba626054 100644
> > --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > @@ -27,6 +27,9 @@ Optional properties:
> >                               resolution pwm duty cycle can be used without
> >                               having to list out every possible value in the
> >                               brightness-level array.
> > +  - max-brightness: Maximum brightness value. Used to specify the number of
> > +                    brightness levels (max-brightness + 1) when the node
> > +                    has no 'brightness-levels' table.
> 
> In the LED subsystem we have led-max-microamp property which seems to
> better describe hardware capabilities. It says just: this is the current
> level the LED can withstand. max-brightness does not implicitly convey
> this kind of information.
> 
> Why the need for the property at all? If for the reasons other than
> hardware capabilities than it should be more likely handled
> by userspace.

The driver needs to know how many brightness levels to expose to
userspace. It currently uses a heuristic for that which is broken:

https://elixir.bootlin.com/linux/v5.1.9/source/drivers/video/backlight/pwm_bl.c#L234
https://lore.kernel.org/patchwork/patch/1086777/#1282610

In any case it seems the discussion is going into the direction of
fixing the heuristic (apparently using the period as an indicator of
the PWM resolution has more merit than I was initially aware of), if
that moves forward the property wouldn't be needed.

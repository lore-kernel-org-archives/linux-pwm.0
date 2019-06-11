From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: pwm-backlight: Add 'max-brightness'
 property
Date: Tue, 11 Jun 2019 14:38:01 -0700
Message-ID: <20190611213801.GE137143@google.com>
References: <20190610233739.29477-1-mka@chromium.org>
 <20190611102851.GA16611@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190611102851.GA16611@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

On Tue, Jun 11, 2019 at 12:28:51PM +0200, Thierry Reding wrote:
> On Mon, Jun 10, 2019 at 04:37:38PM -0700, Matthias Kaehlcke wrote:
> > Add an optional 'max-brightness' property, which is used to specify
> > the number of brightness levels (max-brightness + 1) when the node
> > has no 'brightness-levels' table.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  .../devicetree/bindings/leds/backlight/pwm-backlight.txt       | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > index 64fa2fbd98c9..98f4ba626054 100644
> > --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > @@ -27,6 +27,9 @@ Optional properties:
> >                              resolution pwm duty cycle can be used without
> >                              having to list out every possible value in the
> >                              brightness-level array.
> > +  - max-brightness: Maximum brightness value. Used to specify the number of
> > +                    brightness levels (max-brightness + 1) when the node
> > +                    has no 'brightness-levels' table.
> 
> Back at the time when these bindings were defined we specifically didn't
> add this because it was deemed impractical. That is, no real hardware is
> actually capable of achieving useful results with a simplified
> description like this.
> 
> Besides, we already have the num-interpolated-steps property which
> should allow you to achieve the same thing:
> 
> 	brightness-levels = <0 255>;
> 	default-brightness-level = <1>;
> 	num-interpolated-steps = <255>;

It doesn't achieve the same. With this configuration the device would
have a table with 256 linearly increasing values, the intended use of
the property is to provide the number of brightness levels to be used
by the CIE 1931 algorithm to compute a brightness scale that is
perceived as linear by the human eye. We could possibly treat a
'brightness-levels' table with only two levels as special case and
get the number of levels from it.

In any case from the discussion on "backlight: pwm_bl: Get number of
brightness levels for CIE 1931 from the device tree" it might not be
necessary to specify the number of levels in the DT.

> Though given the original discussion that we had around how backlight
> hardware behaves, that doesn't seem like a good choice.

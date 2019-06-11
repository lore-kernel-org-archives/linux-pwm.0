From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 2/2] backlight: pwm_bl: Get number of brightness levels
 for CIE 1931 from the device tree
Date: Tue, 11 Jun 2019 14:58:59 -0700
Message-ID: <20190611215859.GF137143@google.com>
References: <20190610233739.29477-1-mka@chromium.org>
 <20190610233739.29477-2-mka@chromium.org>
 <20190611101843.GD7526@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190611101843.GD7526@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pwm@vger.kernel.org

Hi Pavel,

On Tue, Jun 11, 2019 at 12:18:43PM +0200, Pavel Machek wrote:
> On Mon 2019-06-10 16:37:39, Matthias Kaehlcke wrote:
> > Commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> > linearly to human eye") uses pwm_period / hweight32(pwm_period) as
> > as heuristic to determine the number of brightness levels when the DT
> > doesn't provide a brightness level table. This heuristic is broken
> > and can result in excessively large brightness tables.
> > 
> > Instead of using the heuristic try to retrieve the number of
> > brightness levels from the device tree (property 'max-brightness'
> > + 1). If the value is not specified use a default of 256 levels.
> > 
> > Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
> 
> I don't think this one is suitable for stable. I'm pretty sure the
> heuristics works well for many boards, and you just replaced it with
> another heuristics ("256").

whether the patch is suitable for stable/upstream is certainly
debatable, in any case I'd argue the current heuristic is bogus and
works by accident or at a cost:

nlevels = period / hweight(period)

w/ period = 131071 ns  (0x1FFFF)

  nlevels = 131071 / 17 = 7710

w/ period = 131072 ns (0x20000)

  nlevels = 131072 / 1 = 131072

and some PWMs use significantly higher periods like 1 ms or 10 ms.

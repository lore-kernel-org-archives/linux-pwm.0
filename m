From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 2/2] backlight: pwm_bl: Get number of brightness levels
 for CIE 1931 from the device tree
Date: Tue, 11 Jun 2019 10:01:23 -0700
Message-ID: <20190611170123.GD137143@google.com>
References: <20190610233739.29477-1-mka@chromium.org>
 <20190610233739.29477-2-mka@chromium.org>
 <20190611153314.cj6j6l4kcl4kk4t2@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190611153314.cj6j6l4kcl4kk4t2@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pwm@vger.kernel.org

Hi Daniel,

On Tue, Jun 11, 2019 at 04:33:14PM +0100, Daniel Thompson wrote:
> On Mon, Jun 10, 2019 at 04:37:39PM -0700, Matthias Kaehlcke wrote:
> > Commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> > linearly to human eye") uses pwm_period / hweight32(pwm_period) as
> > as heuristic to determine the number of brightness levels when the DT
> > doesn't provide a brightness level table. This heuristic is broken
> > and can result in excessively large brightness tables.
> > 
> > Instead of using the heuristic try to retrieve the number of
> > brightness levels from the device tree (property 'max-brightness'
> > + 1). If the value is not specified use a default of 256 levels.
> 
> I'll look at the code tomorrow but why 256?
> 
> To me it feels simultaneously too big for a simple 8-bit PWM and too
> small for animated backlight effects.

I agree there is no one-size-fits-it-all default, 256 seemed like a
possible compromise.

> I certainly agree that an override could be useful but I'm not clear why
> deriving a default based on the period is bogus (and the description is
> merely concerned about uselessly big tables).

Maybe it's not necessarily bogus, but the current heuristic that
counts the number of set bits (hweight()) in the period certainly is.

IIUC the period provides a clue about the PWM resolution, because it
would be hard/impossible to accomodate the high resolution in shorter
periods.

> /*
>  * Once we have 4096 levels there's little point going much higher...
>  * neither interactive sliders nor animation benefits from having
>  * more values in the table.
>  */
> max_brightness = min(DIV_ROUND_UP(period, ffs(period), 4096);

I was also considering something along these lines, but wasn't sure
if there is indeed a relation between the period and the PWM
resolution. I take your suggestion as a confirmation :)

From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v3 2/4] backlight: Expose brightness curve type through
 sysfs
Date: Fri, 16 Aug 2019 10:53:17 -0700
Message-ID: <20190816175317.GU250418@google.com>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190807201528.GO250418@google.com>
 <510f6d8a-71a0-fa6e-33ea-c4a4bfa96607@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <510f6d8a-71a0-fa6e-33ea-c4a4bfa96607@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Pavel Machek <pavel@ucw.cz>, Jacek Anaszewski <jacek.anaszewski@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Fri, Aug 16, 2019 at 04:54:18PM +0100, Daniel Thompson wrote:
> On 07/08/2019 21:15, Matthias Kaehlcke wrote:
> > On Tue, Jul 09, 2019 at 12:00:05PM -0700, Matthias Kaehlcke wrote:
> > > Backlight brightness curves can have different shapes. The two main
> > > types are linear and non-linear curves. The human eye doesn't
> > > perceive linearly increasing/decreasing brightness as linear (see
> > > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> > > linearly to human eye"), hence many backlights use non-linear (often
> > > logarithmic) brightness curves. The type of curve currently is opaque
> > > to userspace, so userspace often uses more or less reliable heuristics
> > > (like the number of brightness levels) to decide whether to treat a
> > > backlight device as linear or non-linear.
> > > 
> > > Export the type of the brightness curve via the new sysfs attribute
> > > 'scale'. The value of the attribute can be 'linear', 'non-linear' or
> > > 'unknown'. For devices that don't provide information about the scale
> > > of their brightness curve the value of the 'scale' attribute is 'unknown'.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > 
> > Daniel (et al): do you have any more comments on this patch/series or
> > is it ready to land?
> 
> I decided to leave it for a long while for others to review since I'm still
> a tiny bit uneasy about the linear/non-linear terminology.
> 
> However that's my only concern, its fairly minor and I've dragged by feet
> for more then long enough, so:
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Thanks!

If you or someone else has another suggestion for the terminology that
we can all agree on I'm happy to change it.

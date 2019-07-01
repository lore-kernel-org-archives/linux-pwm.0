From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2 2/4] backlight: Expose brightness curve type through
 sysfs
Date: Mon, 1 Jul 2019 09:55:23 -0700
Message-ID: <20190701165523.GD137143@google.com>
References: <20190624203114.93277-1-mka@chromium.org>
 <20190624203114.93277-3-mka@chromium.org>
 <20190626145611.GA22348@xo-6d-61-c0.localdomain>
 <20190628083452.tlgcylwo34lxi4s6@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190628083452.tlgcylwo34lxi4s6@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hi,

On Fri, Jun 28, 2019 at 09:34:52AM +0100, Daniel Thompson wrote:
> On Wed, Jun 26, 2019 at 04:56:11PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > Export the type of the brightness curve via the new sysfs attribute
> > > 'scale'. The value of the attribute may be a simple string like
> > > 'linear' or 'non-linear', or a composite string similar to
> > > 'compatible' strings of the device tree. A composite string consists
> > > of different elements separated by commas, starting with the
> > > most-detailed description and ending with the least-detailed one. An
> > > example for a composite string is "cie-1931,perceptual,non-linear"
> > > This brightness curve was generated with the CIE 1931 algorithm, it
> > > is perceptually linear, but not actually linear in terms of the
> > > emitted light. If userspace doesn't know about 'cie-1931' or
> > > 'perceptual' it should at least be able to interpret the 'non-linear'
> > > part.
> > 
> > I'm not sure the comma-separated thing is a good idea. If it is, it should 
> > go to the Documentation, not to changelog.
> 
> So I viewed the comma-separated thing as allow us to describe facts about
> the scale used.
> 
> In particular I suspect that some controllers will be non-linear *and*
> non-perceptual and that some userspaces, particularly those that animate
> backlight changes, may care enough about the difference to ask us to add
> another fact to the set that describes that scale.
> 
> Having said that I do share your concern that the comma-separated list
> is overengineered and that all userspaces will end up implementing
> something like:
> 
> if (strstr("non-linear", scale) {
>   mode = PERCEPTUAL;
> } else if (strstr("unknown", scale) {
>   mode = use_existing_hueristic();
> } else {
>   mode = LINEAR;
> }

I agree that this is not unlikely ...

So let's just make it 'linear', 'non-linear' and 'unknown'?

> > > +What:		/sys/class/backlight/<backlight>/scale
> > > +Date:		June 2019
> > > +KernelVersion:	5.4
> > > +Contact:	Daniel Thompson <daniel.thompson@linaro.org>
> > > +Description:
> > > +		Description of the scale of the brightness curve. The
> > > +		description consists of one or more elements separated by
> > > +		commas, from the most detailed to the least detailed
> > > +		description.
> > > +
> > > +		Possible values are:
> > > +
> > > +		unknown
> > > +		  The scale of the brightness curve is unknown.
> > > +
> > > +		linear
> > > +		  The brightness changes linearly in terms of the emitted
> > > +		  light, changes are perceived as non-linear by the human eye.
> > > +
> > > +		non-linear
> > > +		  The brightness changes non-linearly in terms of the emitted
> > > +		  light, changes might be perceived as linear by the human eye.
> > 
> > non-linear is not too useful as described.
> 
> Agree.
> 
> The idea is that allows a userspace with simple backlight needs to
> simple map the brightness property directly to a slider using the
> approach above without worrying about perceptual or (possible future)
> logarithmic scales. Such an approach won't be perfect but it
> probably won't feel horrible for the user either.
> 
> Arguably the descriptions should move away from the raw factual
> approach and describe what advise the kernel of offering the
> userspace.

ok, I'll change it in the next revision

> > > +		perceptual,non-linear
> > > +		  The brightness changes non-linearly in terms of the emitted
> > > +		  light, changes should be perceived as linear by the human eye.
> > > +
> > > +		cie-1931,perceptual,non-linear
> > > +		  The brightness curve was calculated with the CIE 1931
> > > +		  algorithm. Brightness changes non-linearly in terms of the
> > > +		  emitted light, changes should be perceived as linear by the
> > > +		  human eye.
> > 
> > Is it useful to know difference between perceptual, and cie-1931?
> 
> Depends how assertive the userspaces are!
> 
> If they follow the "fix kernel bugs in the kernel" mantra rather than
> implement workarounds and heuristics then I suspect it would not be used
> much.
> 
> 
> > Would it be useful to export absolute values in some well-known units?
> > 
> > If I'm in dark room, I may want 100mW/m^2 of backlight... And it would
> > be nice if I could set same backlight intensity on all my devices
> > easily.
> 
> I'm a little sceptical that we could calibrate an absolute scale on
> enough devices for such a property to be useful. I think it would be
> "unknown" on almost every system.

I share your scepticism and would expect most devices to remain
"unknown"

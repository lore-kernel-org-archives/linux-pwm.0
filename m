From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v3 2/4] backlight: Expose brightness curve type through
 sysfs
Date: Thu, 29 Aug 2019 15:09:05 +0100
Message-ID: <20190829140905.wkv2pwzmhhfyzan4@holly.lan>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190807201528.GO250418@google.com>
 <510f6d8a-71a0-fa6e-33ea-c4a4bfa96607@linaro.org>
 <20190816175317.GU250418@google.com>
 <20190819100241.5pctjxmsq6crlale@holly.lan>
 <20190819185049.GZ250418@google.com>
 <20190820135617.64urowbu2kwdynib@holly.lan>
 <20190827094459.GB4804@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190827094459.GB4804@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Pavel Machek <pavel@ucw.cz>, Jacek Anaszewski <jacek.anaszewski@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Tue, Aug 27, 2019 at 10:44:59AM +0100, Lee Jones wrote:
> [...]
> 
> > > IIUC the conclusion is that there is no need for a string attribute
> > > because we only need to distinguish between 'perceptual' and
> > > 'non-perceptual'. If that is correct, do you have any preference for
> > > the attribute name ('perceptual_scale', 'perceptual', ...)?
> > 
> > More a summary than a conclusion! There is a reason I have left a bit or
> > space for others to comment on this over the last month (and a bit).
> > 
> > To be clear my Reviewed-by: means that I believe that the kernel is better
> > with "non-linear/linear/unknown" than without it and that I am comfortable
> > the API isn't likely to be a millstone for us.
> > 
> > Lee, Jingoo: Either of you care to offer $0.02
> 
> No, not really.  Happy to leave it to your good judgement.

In that case... the patch has my reviewed-by and although the concerns
raised in the associated threads have merit I don't think they are
enough to stop the patch.

Please merge.


Daniel.

> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

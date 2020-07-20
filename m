From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v5 0/19] backlight: backlight updates
Date: Mon, 20 Jul 2020 13:01:12 +0200
Message-ID: <20200720110112.GA147689@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
 <20200720093601.GA3368211@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:53528 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgGTLBU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2020 07:01:20 -0400
Content-Disposition: inline
In-Reply-To: <20200720093601.GA3368211@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Daniel Thompson <daniel.thompson@linaro.org>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>

Hi Lee.

On Mon, Jul 20, 2020 at 10:36:01AM +0100, Lee Jones wrote:
> On Sun, 19 Jul 2020, Sam Ravnborg wrote:
> 
> > Hi all.
> > 
> > Follow-up on v4 - with only a few changes listed below and
> > in the individual patches.
> > Thanks for all the reviews and the feedback on the patches!
> > 
> > I am planning a follow-up on this patchset to update the
> > backlight drivers all over to use backlight_get_brightness()
> > and backlight_is_blank() as appropriate.
> 
> [...]
> 
> > Sam Ravnborg (19):
> >       backlight: refactor fb_notifier_callback()
> >       backlight: add backlight_is_blank()
> >       backlight: improve backlight_ops documentation
> >       backlight: improve backlight_properties documentation
> >       backlight: improve backlight_device documentation
> >       backlight: document inline functions in backlight.h
> >       backlight: document enums in backlight.h
> >       backlight: remove the unused backlight_bl driver
> >       backlight: drop extern from prototypes
> >       backlight: add overview and update existing doc
> >       backlight: wire up kernel-doc documentation
> >       backlight: introduce backlight_get_brightness()
> >       backlight: as3711_bl: simplify update_status
> >       backlight: cr_bllcd: introduce gpio-backlight semantics
> >       backlight: gpio_backlight: simplify update_status()
> >       backlight: jornada720_bl: introduce backlight_is_blank()
> >       backlight: use backlight_get_brightness()
> >       backlight: drop backlight_put()
> >       backlight: make of_find_backlight static
> 
> All applied, but to be honest, that was quite painful.
That was not the intention :-(

> 
> A few notes for subsequent patches.
> 
>  - Enable spell-checkers in your editors
>    - I fixed the issues up for you here - there were quite a few!
>  - Run ./checkpatch.pl before submitting - here's what I find useful
>    * .git/hooks/post-commit: https://pastebin.ubuntu.com/p/WpPFd6M2rB/
>  - Please keep the in-patch changelog below the '---' line, so that it
>    does not end up in the final commit log
>  - Cc: lines *above* the *-bys please
>  - Cc: lines dropped for any *-bys provided
>  - Lines wrapped ~72 chars (not 50)
>  - One whole empty line spacing between paragraphs
>  - Ensure you use the formatting expected of the subsystem - in the
>    case of Backlight it's:
> 
>      <subsystem>: <file>: Subject beginning with an upper-case char
> 
>    A `git log --oneline -- subsystem` would give you a good idea of
>    what's expected.

Thanks for the input - I will use these points as guideline for the next
batch of backlight patches.

	Sam

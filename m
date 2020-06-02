From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v3 0/16] backlight updates
Date: Tue, 2 Jun 2020 15:04:39 +0100
Message-ID: <CACvgo51z0Vvz9LkfqePmuwx19+NhaMEBHe9r5=uYWqhEdnia_Q@mail.gmail.com>
References: <20200601065207.492614-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgFBOH6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 10:07:58 -0400
In-Reply-To: <20200601065207.492614-1-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas

Hi Sam,

On Mon, 1 Jun 2020 at 07:52, Sam Ravnborg <sam@ravnborg.org> wrote:
>
> v3:
>  - Dropped video patch that was reviewd and thus applied
>  - Updated kernel-doc so all fields now have a short intro
>  - Improved readability in a lot of places, thanks to review
>    feedback from Daniel - thanks!
>  - Added better intro to backlight
>  - Added acks
>
>    Several other smaller changes documented in the
>    patches.
>    I left out patches to make functions static as
>    there are dependencies to drm-misc-next for these.
>    When this is landed I have a pile of follow-up patches waiting,
>    mostly introducing backlight_is_blank() all over.
>
What happened with my suggestion to use backlight_is_blank() in fbdev
core itself?
It effectively makes 13/13 and the above mentioned follow-up series obsolete.

That said, series look spot on. With the documentation fixed (pointer
by Daniel) patches 1-12 are:
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

-Emil

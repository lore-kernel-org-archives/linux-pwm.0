From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v4 16/20] backlight: jornada720_bl: introduce
 backlight_is_blank()
Date: Wed, 8 Jul 2020 12:12:33 +0100
Message-ID: <20200708111233.ui6r6bvdchj3vboj@holly.lan>
References: <20200703184546.144664-1-sam@ravnborg.org>
 <20200703184546.144664-17-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbgGHLMh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jul 2020 07:12:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311DAC08E6DC
        for <linux-pwm@vger.kernel.org>; Wed,  8 Jul 2020 04:12:37 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so2479596wmh.4
        for <linux-pwm@vger.kernel.org>; Wed, 08 Jul 2020 04:12:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200703184546.144664-17-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe

On Fri, Jul 03, 2020 at 08:45:42PM +0200, Sam Ravnborg wrote:
> Use the backlight_is_blank() helper to simplify the code a bit.
> This add support for fb_blank as a side-effect.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

This driver exhibits the "how does userspace know what writing brightness zero to
sysfs actually does" problem so can't use the backlight_get_brightness() helper.

If you respin it would be good to see that in the patch description but
that's such an extreme nitpick It think, either way, this can be:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

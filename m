From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 7/8] drm/i915: Use the CRC gpio for panel enable/disable
Date: Tue, 12 May 2015 13:10:30 +0200
Message-ID: <CACRpkdYkZay7XbxzkvAmU7Bt0YT23rS-EyXJMtt05UMLF8MKEA@mail.gmail.com>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
	<1430316005-16480-8-git-send-email-shobhit.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36199 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbbELLKb (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 12 May 2015 07:10:31 -0400
Received: by obbkp3 with SMTP id kp3so2529799obb.3
        for <linux-pwm@vger.kernel.org>; Tue, 12 May 2015 04:10:30 -0700 (PDT)
In-Reply-To: <1430316005-16480-8-git-send-email-shobhit.kumar@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Shobhit Kumar <shobhit.kumar@intel.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, linux-pwm <linux-pwm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Alexandre Courbot <gnurou@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@linux.ie>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Lee Jones <lee.jones@linaro.org>, Povilas Staniulis <wdmonster@gmail.com>, Chih-Wei Huang <cwhuang@android-x86.org>

On Wed, Apr 29, 2015 at 4:00 PM, Shobhit Kumar <shobhit.kumar@intel.com> wrote:

> The CRC (Crystal Cove) PMIC, controls the panel enable and disable
> signals for BYT for dsi panels. This is indicated in the VBT fields. Use
> that to initialize and use GPIO based control for these signals.
>
> v2: Use the newer gpiod interface(Alexandre)
> v3: Remove the redundant checks and unused code (Ville)
>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

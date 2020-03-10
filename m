From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v7 12/13] backlight: pwm_bl: Use 64-bit division macros
 for period and duty cycle
Date: Tue, 10 Mar 2020 11:12:42 -0700
Message-ID: <20200310181242.GA31738@codeaurora.org>
References: <cover.1583782035.git.gurus@codeaurora.org>
 <bf6d8f6190d266f8992bd5451b12c9f3962fd18e.1583782035.git.gurus@codeaurora.org>
 <20200310143432.cfjlqac5x6oinshj@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38739 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726464AbgCJSMo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Mar 2020 14:12:44 -0400
Content-Disposition: inline
In-Reply-To: <20200310143432.cfjlqac5x6oinshj@holly.lan>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

On Tue, Mar 10, 2020 at 02:34:32PM +0000, Daniel Thompson wrote:
> This patch looks like it is a tiny change to get the pwm_backlight to
> perform 64-bit division. Most of the above text is completely irrelevant
> to the change contained in this patch. No need to justify the change in
> the PWM structures here since that can go in the patch that changes
> those structures.  Just describe what this patch does, perhaps something
> like the following:
> 
>     The PWM API will shortly switch the state.period and
>     state.duty_cycle fields to 64-bit values. Make pwm_bl
>     ready for this transition by adopting 64-bit division
>     macros.

Will update the commit text accordingly.

> Also please copy the backlight maintainers into the covering letter. It
> is useful to place patches like this into context.

Will do.

Thank you.

Guru Das.

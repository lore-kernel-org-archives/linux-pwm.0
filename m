Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37712 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfJQHXP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 03:23:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so1049742wro.4
        for <linux-pwm@vger.kernel.org>; Thu, 17 Oct 2019 00:23:13 -0700 (PDT)
Date: Thu, 17 Oct 2019 08:23:11 +0100
From: Lee Jones <lee.jones@linaro.org>
Message-ID: <20191017072311.GJ4365@dell>
References: <20191016110601.1765415-1-thierry.reding@gmail.com>
 <20191016110601.1765415-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016110601.1765415-2-thierry.reding@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2 1/3] pwm: stm32: Remove clutter from ternary operator
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org

On Wed, 16 Oct 2019, Thierry Reding wrote:

> Remove usage of the ternary operator to assign values for register
> fields. Instead, parameterize the register and field offset macros
> and pass the index to them.
> 
> This removes clutter and improves readability.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-stm32.c          | 21 +++++++++------------

>  include/linux/mfd/stm32-timers.h | 12 ++++--------

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

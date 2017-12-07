From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH] pwn: stm32: Adopt SPDX identifier
Date: Thu, 7 Dec 2017 11:11:13 +0100
Message-ID: <CAOFm3uFYjUvnwb2zqdJEuHp4WEnfmxrcZxRta2Cnfz3Q1=55rw@mail.gmail.com>
References: <20171205145721.20403-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39117 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbdLGKLz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 7 Dec 2017 05:11:55 -0500
Received: by mail-wr0-f194.google.com with SMTP id a41so6854471wra.6
        for <linux-pwm@vger.kernel.org>; Thu, 07 Dec 2017 02:11:54 -0800 (PST)
In-Reply-To: <20171205145721.20403-1-benjamin.gaignard@st.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: thierry.reding@gmail.com, Alexandre Torgue <alexandre.torgue@st.com>, linux-pwm@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Benjamin Gaignard <benjamin.gaignard@st.com>

On Tue, Dec 5, 2017 at 3:57 PM, Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> Add SPDX identifer
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 3 +--
>  drivers/pwm/pwm-stm32.c    | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> index 1ac9e4384142..cbd271e80c3c 100644
> --- a/drivers/pwm/pwm-stm32-lp.c
> +++ b/drivers/pwm/pwm-stm32-lp.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * STM32 Low-Power Timer PWM driver
>   *
> @@ -5,8 +6,6 @@
>   *
>   * Author: Gerald Baeza <gerald.baeza@st.com>
>   *
> - * License terms: GNU General Public License (GPL), version 2
> - *
>   * Inspired by Gerald Baeza's pwm-stm32 driver
>   */
>
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 6139512aab7b..be56d7af89c9 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -1,10 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) STMicroelectronics 2016
>   *
>   * Author: Gerald Baeza <gerald.baeza@st.com>
>   *
> - * License terms: GNU General Public License (GPL), version 2
> - *
>   * Inspired by timer-stm32.c from Maxime Coquelin
>   *             pwm-atmel.c from Bo Shen
>   */
> --
> 2.15.0
>


Thank you for using the simpler SPDX license ids!

Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

-- 
Cordially
Philippe Ombredanne

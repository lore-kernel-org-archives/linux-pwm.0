From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 5/8] IIO: add bindings for STM32 timer trigger driver
Date: Mon, 12 Dec 2016 13:28:09 -0600
Message-ID: <20161212192809.hwcq2owmybacsqke@rob-hp-laptop>
References: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
 <1481292919-26587-6-git-send-email-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34599 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbcLLT2L (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Dec 2016 14:28:11 -0500
Content-Disposition: inline
In-Reply-To: <1481292919-26587-6-git-send-email-benjamin.gaignard@st.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: lee.jones@linaro.org, mark.rutland@arm.com, alexandre.torgue@st.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com, gerald.baeza@st.com, arnaud.pouliquen@st.com, linus.walleij@linaro.org, linaro-kernel@lists.linaro.org, Benjamin Gaignard <benjamin.gaignard@st.com>

On Fri, Dec 09, 2016 at 03:15:16PM +0100, Benjamin Gaignard wrote:
> Define bindings for STM32 timer trigger
> 
> version 4:
> - remove triggers enumeration from DT
> - add reg parameter
> 
> version 3:
> - change file name
> - add cross reference with mfd bindings
> 
> version 2:
> - only keep one compatible
> - add DT parameters to set lists of the triggers:
>   one list describe the triggers created by the device
>   another one give the triggers accepted by the device
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/iio/timer/stm32-timer-trigger.txt     | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt

Other than same comments I made in the other patches for the example, 
looks fine.

Acked-by: Rob Herring <robh@kernel.org>

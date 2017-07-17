From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/9] dt-bindings: mfd: Add STM32 LPTimer binding
Date: Mon, 17 Jul 2017 19:34:08 +0100
Message-ID: <20170717183408.rk2lutdcvwl4gn4v@dell>
References: <1499445068-7037-1-git-send-email-fabrice.gasnier@st.com>
 <1499445068-7037-2-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37213 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdGQSeM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Jul 2017 14:34:12 -0400
Received: by mail-wm0-f43.google.com with SMTP id b134so2827338wma.0
        for <linux-pwm@vger.kernel.org>; Mon, 17 Jul 2017 11:34:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1499445068-7037-2-git-send-email-fabrice.gasnier@st.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: benjamin.gaignard@linaro.org, jic23@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

On Fri, 07 Jul 2017, Fabrice Gasnier wrote:

> Add documentation for STMicroelectronics STM32 Low-Power Timer binding.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
> Changes in v3:
> - Rob's comment on node name: timer@...
> 
> Changes in v2:
> - Lee's comments: s/Low Power/Low-Power/, remove 0x in example, improve
>   properties descriptions
> ---
>  .../devicetree/bindings/mfd/stm32-lptimer.txt      | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

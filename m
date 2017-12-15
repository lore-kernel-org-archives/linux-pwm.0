From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2] ARM64: dts: meson-axg: add PWM DT info for Meson-Axg SoC
Date: Fri, 15 Dec 2017 11:51:05 -0800
Message-ID: <7h609793di.fsf@baylibre.com>
References: <20171215024739.106705-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33709 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756139AbdLOTvH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Dec 2017 14:51:07 -0500
Received: by mail-pg0-f67.google.com with SMTP id g7so6467902pgs.0
        for <linux-pwm@vger.kernel.org>; Fri, 15 Dec 2017 11:51:07 -0800 (PST)
In-Reply-To: <20171215024739.106705-1-yixun.lan@amlogic.com> (Yixun Lan's
        message of "Fri, 15 Dec 2017 10:47:39 +0800")
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>

Yixun Lan <yixun.lan@amlogic.com> writes:

> From: Jian Hu <jian.hu@amlogic.com>
>
> Add PWM DT info for the Amlogic's Meson-Axg SoC.
>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>
> ---
> Changes in v2 since [1]
>  - drop clock DT info from soc.dtsi

Applied to v4.16/dt64,

Thanks,

Kevin

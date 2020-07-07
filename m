From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 4/8] arm64: dts: exynos: Remove DMA controller bus
 node name to fix dtschema warnings
Date: Tue, 7 Jul 2020 08:44:17 +0200
Message-ID: <20200707064417.GB15031@kozik-lap>
References: <20200702155149.12854-1-krzk@kernel.org>
 <20200702155149.12854-4-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55953 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGGoX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jul 2020 02:44:23 -0400
Content-Disposition: inline
In-Reply-To: <20200702155149.12854-4-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>

On Thu, Jul 02, 2020 at 05:51:45PM +0200, Krzysztof Kozlowski wrote:
> There is no need to keep DMA controller nodes under AMBA bus node.
> Remove the "amba" node to fix dtschema warnings like:
> 
>     amba: $nodename:0: 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:

Applied.

Best regards,
Krzysztof

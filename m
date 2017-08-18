From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 7/7] arm64: dts: rockchip: Add pwm nodes for rk3328
Date: Sat, 19 Aug 2017 01:06:43 +0200
Message-ID: <2426743.6zMP1RcfyD@phil>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com> <1502206995-24418-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:35626 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751114AbdHRXGw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 18 Aug 2017 19:06:52 -0400
In-Reply-To: <1502206995-24418-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: thierry.reding@gmail.com, boris.brezillon@free-electrons.com, robh+dt@kernel.org, catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Am Dienstag, 8. August 2017, 23:43:15 CEST schrieb David Wu:
> There are 4 pwm channels built in rk3328 soc, need to configure
> the both APB clock and bus clock.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>

applied for 4.14 with some property movements.


Thanks
Heiko

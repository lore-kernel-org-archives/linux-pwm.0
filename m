From: "David.Wu" <david.wu@rock-chips.com>
Subject: Re: [PATCH v3 0/7] Add rk3328 pwm support
Date: Mon, 14 Aug 2017 10:46:54 +0800
Message-ID: <7e5a11c1-5f1d-9dff-435f-2624d95e16a3@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:58296 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbdHNCq6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 13 Aug 2017 22:46:58 -0400
In-Reply-To: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, heiko@sntech.de, boris.brezillon@free-electrons.com, robh+dt@kernel.org
Cc: catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Boris && thierry,

Do you have any other suggestion for the patches?

ÔÚ 2017/8/8 23:38, David Wu Ð´µÀ:
> There are two features of rk3328 pwm module.
>   - PWM APB and function clocks are different.
>   - Add pwm atomic hardware update
> 
> David Wu (7):
>    pwm: rockchip: Add APB and function both clocks support
>    pwm: rockchip: Remove the judge from return value of pwm_config
>    pwm: rockchip: Use pwm_apply instead of the pwm_enable
>    pwm: rockchip: Move the configuration of polarity from
>      rockchip_pwm_set_enable() to rockchip_pwm_config()
>    pwm: rockchip: Use same pwm ops for each IP
>    pwm: rockchip: Add rk3328 pwm support
>    arm64: dts: rockchip: Add pwm nodes for rk3328
> 
>   .../devicetree/bindings/pwm/pwm-rockchip.txt       |   8 +-
>   arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  45 ++++
>   drivers/pwm/pwm-rockchip.c                         | 281 +++++++++++----------
>   3 files changed, 199 insertions(+), 135 deletions(-)
> 

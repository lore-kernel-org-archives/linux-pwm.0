From: "David.Wu" <david.wu@rock-chips.com>
Subject: Re: [PATCH 3/5] pwm: rockchip: Move the configuration of polarity
 from rockchip_pwm_set_enable() to rockchip_pwm_config()
Date: Tue, 4 Jul 2017 14:46:29 +0800
Message-ID: <681d6ce3-aae4-7d4f-2fec-e8af8f4f9436@rock-chips.com>
References: <1498739271-27431-1-git-send-email-david.wu@rock-chips.com>
 <1498739271-27431-4-git-send-email-david.wu@rock-chips.com>
 <20170703203640.697b8286@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170703203640.697b8286@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: thierry.reding@gmail.com, heiko@sntech.de, robh+dt@kernel.org, catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Boris,

ÔÚ 2017/7/4 2:36, Boris Brezillon Ð´µÀ:
> Hm, maybe it's time to drop these custom hooks and implement
> pwm_apply_v1 and pwm_apply_v2 instead.

Okay, drop the enable and config hooks, only use the apply hook to 
instead them.

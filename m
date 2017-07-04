From: "David.Wu" <david.wu@rock-chips.com>
Subject: Re: [PATCH 4/5] pwm: rockchip: Add atomic updated feature for rk3328
Date: Tue, 4 Jul 2017 15:37:54 +0800
Message-ID: <05cccb3d-2b35-1878-6173-9a96adef17ba@rock-chips.com>
References: <1498739271-27431-1-git-send-email-david.wu@rock-chips.com>
 <1498739271-27431-5-git-send-email-david.wu@rock-chips.com>
 <20170703203957.03f3d1db@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:58409 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751954AbdGDHiN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 Jul 2017 03:38:13 -0400
In-Reply-To: <20170703203957.03f3d1db@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: thierry.reding@gmail.com, heiko@sntech.de, robh+dt@kernel.org, catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Boris,

ÔÚ 2017/7/4 2:39, Boris Brezillon Ð´µÀ:
> Yet another customization. Don't you think we can extract common parts,
> expose them as helpers and then have 3 different pwm_ops (with 3
> different ->apply() implementation), one for each IP revision.

Sounds reasonable.I will try to implement 3 different apply().

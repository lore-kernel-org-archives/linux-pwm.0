From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/5] pwm: rockchip: Add atomic updated feature for rk3328
Date: Thu, 6 Jul 2017 12:17:57 -0500
Message-ID: <20170706171757.qmnvmdyjuj77tt27@rob-hp-laptop>
References: <1498739271-27431-1-git-send-email-david.wu@rock-chips.com>
 <1498739271-27431-5-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:34193 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbdGFRSA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Jul 2017 13:18:00 -0400
Content-Disposition: inline
In-Reply-To: <1498739271-27431-5-git-send-email-david.wu@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: thierry.reding@gmail.com, heiko@sntech.de, boris.brezillon@free-electrons.com, catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 29, 2017 at 08:27:50PM +0800, David Wu wrote:
> The rk3328 soc supports atomic update, we could lock the configuration
> of period and duty at first, after unlock is configured, the period and
> duty are effective at the same time.
> 
> If the polarity, period and duty need to be configured together,
> the way for atomic update is "configure lock and old polarity" ->
> "configure period and duty" -> "configure unlock and new polarity".
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  .../devicetree/bindings/pwm/pwm-rockchip.txt       |  1 +

The subject is a bit misleading as you are adding support for a new 
version of the IP. Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pwm/pwm-rockchip.c                         | 50 +++++++++++++++++++---
>  2 files changed, 46 insertions(+), 5 deletions(-)

From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 3/8] dt-bindings: pwm: add description for rv1108 pwm
Date: Thu, 17 Aug 2017 15:47:35 -0500
Message-ID: <20170817204735.vyifljtv5gxrcku6@rob-hp-laptop>
References: <1502699477-8063-1-git-send-email-andy.yan@rock-chips.com>
 <1502699868-8315-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33600 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbdHQUrr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Aug 2017 16:47:47 -0400
Content-Disposition: inline
In-Reply-To: <1502699868-8315-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: thierry.reding@gmail.com, heiko@sntech.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Mon, Aug 14, 2017 at 04:37:48PM +0800, Andy Yan wrote:
> Add device tree bindings document for pwm on
> rockchip rv1108 soc.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> Changes in v4: None
> Changes in v3:
> - make the compatible string be: "rockchip,rv1108-pwm", "rockchip,rk3288-pwm"
>   for rv1108
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/pwm/pwm-rockchip.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>

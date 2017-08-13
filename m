From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 06/13] dt-bindings: pwm: add description for rv1108 pwm
Date: Sun, 13 Aug 2017 12:54:50 +0200
Message-ID: <3776993.0yRkRa75EH@phil>
References: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com> <1502423046-30988-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:51838 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751403AbdHMKzB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 13 Aug 2017 06:55:01 -0400
In-Reply-To: <1502423046-30988-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: robh+dt@kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Andy,

Am Freitag, 11. August 2017, 11:44:06 CEST schrieb Andy Yan:
> Add device tree bindings document for pwm on
> rockchip rv1108 soc.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

I think you forgot to add Thierry (thierry.reding@gmail.com)
who is the pwm maintainer, to your binding patch.

Especially, as normally he would take this binding patch.


Heiko

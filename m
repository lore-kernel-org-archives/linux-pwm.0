From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Add MediaTek PWM bindings
Date: Fri, 27 Jan 2017 14:59:57 -0600
Message-ID: <20170127205957.esvtrbok47xmrkra@rob-hp-laptop>
References: <1485196477-669-1-git-send-email-john@phrozen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34613 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdA0VA1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 27 Jan 2017 16:00:27 -0500
Content-Disposition: inline
In-Reply-To: <1485196477-669-1-git-send-email-john@phrozen.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: John Crispin <john@phrozen.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, Sean Wang =?utf-8?B?KOeOi+W/l+S6mCk=?= <sean.wang@mediatek.com>

On Mon, Jan 23, 2017 at 07:34:36PM +0100, John Crispin wrote:
> Document the device-tree binding of MediaTek PWM. The PWM has 5 channels.
> This has been tested on MT7623 only but should work on all the other MTK
> SoCs that contain this core.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  .../devicetree/bindings/pwm/pwm-mediatek.txt       |   34 ++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt

Acked-by: Rob Herring <robh@kernel.org>

Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45716 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfJORUj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Oct 2019 13:20:39 -0400
Date: Tue, 15 Oct 2019 12:20:36 -0500
From: Rob Herring <robh@kernel.org>
Message-ID: <20191015172036.GA27358@bogus>
References: <1569931360-17196-1-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569931360-17196-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: rcar: Add r8a774b1 support
To: Biju Das <biju.das@bp.renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Biju Das <biju.das@bp.renesas.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Chris Paterson <Chris.Paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, linux-renesas-soc@vger.kernel.org

On Tue,  1 Oct 2019 13:02:40 +0100, Biju Das wrote:
> Document RZ/G2N (R8A774B1) SoC bindings.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
> This patch depend on
> https://patchwork.kernel.org/patch/11154813/
> ---
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks.

Rob

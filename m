From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 2/5] dt-bindings: pwm: rcar: Document r8a774[35] PWM
 bindings
Date: Wed, 20 Dec 2017 09:31:37 +0100
Message-ID: <20171220083137.63jj4rrkztguvvbm@verge.net.au>
References: <1513690500-12165-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513690500-12165-3-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:52091 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754494AbdLTIbn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Dec 2017 03:31:43 -0500
Content-Disposition: inline
In-Reply-To: <1513690500-12165-3-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org

On Tue, Dec 19, 2017 at 01:34:57PM +0000, Fabrizio Castro wrote:
> This patch adds compatible strings specific to r8a774[35], no driver
> change is needed as the fallback compatible string will activate the
> right code. Also, this patch replaces the example with a DT snippet used
> for adding PWM0 support to an r8a7743 based platform.

What is the motivation for updating the example?
Could it be stated here?

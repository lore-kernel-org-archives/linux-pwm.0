From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/3] dt-bindings: pwm: renesas-tpu: Correct example TPU
 register block size
Date: Wed, 20 Dec 2017 09:21:08 +0100
Message-ID: <20171220082107.qvyihzicuyavekej@verge.net.au>
References: <1513699327-27357-1-git-send-email-geert+renesas@glider.be>
 <1513699327-27357-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:51904 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbdLTIVN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Dec 2017 03:21:13 -0500
Content-Disposition: inline
In-Reply-To: <1513699327-27357-3-git-send-email-geert+renesas@glider.be>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Tue, Dec 19, 2017 at 05:02:06PM +0100, Geert Uytterhoeven wrote:
> The Timer Pulse Unit on R-Mobile A1 has registers that lie outside the
> declared register block.  Enlarge the register block size to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <simon.horman@netronome.com>

With reference to "User's Manual: Hardware" v2.00.

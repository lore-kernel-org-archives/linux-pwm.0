From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH INTERNAL v2 1/3] Documentation: dt: Add Broadcom iproc
 pwm controller binding
Date: Wed, 18 May 2016 17:15:47 -0500
Message-ID: <20160518221546.GA32596@rob-hp-laptop>
References: <1463554441-47982-1-git-send-email-yendapally.reddy@broadcom.com>
 <1463554441-47982-2-git-send-email-yendapally.reddy@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42199 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060AbcERWPx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 18 May 2016 18:15:53 -0400
Content-Disposition: inline
In-Reply-To: <1463554441-47982-2-git-send-email-yendapally.reddy@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Russell King <linux@arm.linux.org.uk>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org

Am I supposed to ignore since this is "internal"?

On Wed, May 18, 2016 at 02:53:59AM -0400, Yendapally Reddy Dhananjaya Reddy wrote:
> Add a binding for Broadcom iproc pwm controller
> 
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> ---
>  .../devicetree/bindings/pwm/brcm,iproc-pwm.txt      | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt

Acked-by: Rob Herring <robh@kernel.org>

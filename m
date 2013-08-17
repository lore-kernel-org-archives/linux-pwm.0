Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:55472 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab3HQVv5 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 17 Aug 2013 17:51:57 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] pwm: renesas-tpu: Add DT support
Date: Sat, 17 Aug 2013 23:53:03 +0200
Message-ID: <2528852.ql9DjmTrjK@avalon>
In-Reply-To: <52091EA5.7070000@wwwdotorg.org>
References: <1374791261-9850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <52091EA5.7070000@wwwdotorg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Ian Campbell <ian.campbell@citrix.com>, Mark Rutland <Mark.Rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <rob.herring@calxeda.com>, Kumar Gala <galak@codeaurora.org>

Hi Stephen,

On Monday 12 August 2013 11:43:01 Stephen Warren wrote:
> On 07/25/2013 04:27 PM, Laurent Pinchart wrote:
> > Specify DT bindings for the TPU PWM controller and add OF support to the
> > driver.
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
> > b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
> > 
> > +  - compatible: should be one of the following.
> > +    - "renesas,tpu-r8a73a4": for R8A77A4 (R-Mobile APE6) compatible PWM
> > controller.
> > +    - "renesas,tpu-r8a7740": for R8A7740 (R-Mobile A1) compatible PWM
> > controller.
>
> In the bindings I've seen, it's more typical for the compatible value to
> be ${vendor},${soc}-${unit} than ${vendor},${unit}-${soc}. I guess I
> don't know how common one format or the other is though.

I'm personally fine with both. However, when using a version number, the 
format is ${vendor},${unit}-${version}. As we don't have an IP core version 
number we use the SoC name instead, so ${vendor},${unit}-${soc} would make 
sense. We should probably decide on one of the two alternatives and document 
it. 

> Other than that, the binding,
> Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
Regards,

Laurent Pinchart


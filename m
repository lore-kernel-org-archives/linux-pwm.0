From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 0/8] r8a7795/6 Salvator-X PWM enablement
Date: Fri, 12 May 2017 14:03:55 +0300
Message-ID: <3796049.09pyf4pHBH@avalon>
References: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com> <4398514.qBghdda7X5@avalon> <CAO3366w2JtF9Ni6_yzuQs7-dEy=LNFSekOyiA9YJbHHvvpPLzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:36645 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdELLDz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 May 2017 07:03:55 -0400
In-Reply-To: <CAO3366w2JtF9Ni6_yzuQs7-dEy=LNFSekOyiA9YJbHHvvpPLzQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, geert@glider.be, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

Hi Ulrich,

On Friday 12 May 2017 12:36:50 Ulrich Hecht wrote:
> On Fri, May 12, 2017 at 12:00 PM, Laurent Pinchart wrote:
> >> * arm64: dts: r8a7795-salvator-x: Enable PWM2
> > 
> > I've asked Ulrich for a clarification on this patch as I'm not sure it's
> > needed, but he hasn't answered yet. Could we delay merging it until the
> > situation is clarified ?
> 
> Enabling it allows to control the switching frequency from userspace
> via sysfs. I guess it's a matter of taste whether to do this by
> default, but I see no downside to it.

For PWM signals that are meant to be used by expansion boards, sure, but this 
one is meant to control the PMIC. I'd rather not let userspace mess with it.

-- 
Regards,

Laurent Pinchart

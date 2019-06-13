Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:41452 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfFMKFR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Jun 2019 06:05:17 -0400
Date: Thu, 13 Jun 2019 12:05:13 +0200
From: Simon Horman <horms@verge.net.au>
Message-ID: <20190613100512.zvyrxavctsaplkkf@verge.net.au>
References: <1559296501-30620-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559296501-30620-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559296501-30620-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v3 3/4] pwm: sysfs: Add suspend/resume support
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Fri, May 31, 2019 at 06:55:00PM +0900, Yoshihiro Shimoda wrote:
> According to the Documentation/pwm.txt, all PWM consumers should have
> power management. Since this sysfs interface is one of consumers so that
> this patch adds suspend/resume support.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

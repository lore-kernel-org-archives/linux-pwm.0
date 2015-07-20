From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH v3 2/2] pwm-pca9685: Support changing the output frequency
Date: Mon, 20 Jul 2015 14:31:18 +0200
Message-ID: <20150720123118.GA28687@pqgruber.com>
References: <1437381369-8502-1-git-send-email-clemens.gruber@pqgruber.com>
 <1437381369-8502-3-git-send-email-clemens.gruber@pqgruber.com>
 <20150720093011.GQ29614@ulmo>
 <20150720094612.GA20084@pqgruber.com>
 <20150720095054.GB20084@pqgruber.com>
 <20150720095813.GU29614@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:55243 "EHLO
	mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbbGTMbV (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 08:31:21 -0400
Content-Disposition: inline
In-Reply-To: <20150720095813.GU29614@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

On Mon, Jul 20, 2015 at 11:58:14AM +0200, Thierry Reding wrote:
> I guess it depends a bit on what the typical use-cases are for this
> chip. Is it usually used only for LEDs (the register names suggest it)?
> If so, how likely is it that people will want to drive them at different
> periods? If it's reasonable to require the same period for all of them,
> maybe it would be worth adding some sort of WARN_ON() or dev_warn() or
> something to notify integrators of this fact.

Not likely. If they read the datasheet of the PCA9685, they should know that
this is not even possible with that chip.

On what condition would you WARN / dev_warn in this case? If the user tries to
set different prescaler values to different channels?

Clemens

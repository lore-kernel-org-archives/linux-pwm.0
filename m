From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH 0/2] pwm-pca9685: Bugfixes and prescaler support
Date: Thu, 9 Jul 2015 15:48:28 +0200
Message-ID: <20150709134828.GA2108@pqgruber.com>
References: <1434582947-11211-1-git-send-email-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:55778 "EHLO
	mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbbGINsc (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jul 2015 09:48:32 -0400
Content-Disposition: inline
In-Reply-To: <1434582947-11211-1-git-send-email-clemens.gruber@pqgruber.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

On Thu, Jun 18, 2015 at 01:15:45AM +0200, Clemens Gruber wrote:
> Hi,
> 
> the first patch from this series contains bugfixes and the second patch
> adds support for changing the PWM output frequency of the PCA9685.
> 
> Clemens Gruber (2):
>   pwm-pca9685: Fix several driver bugs
>   pwm-pca9685: Support changing the output frequency
> 
>  drivers/pwm/pwm-pca9685.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 67 insertions(+), 1 deletion(-)
> 
> -- 
> 2.4.3

Gentle ping.

From: Bart Tanghe <bart.tanghe@thomasmore.be>
Subject: Re: [PATCH v7]pwm: add BCM2835 PWM driver
Date: Wed, 15 Oct 2014 12:33:29 +0200
Message-ID: <543E4D79.3070405@thomasmore.be>
References: <1412763272-24269-1-git-send-email-bart.tanghe@thomasmore.be> <20141014135445.GA26015@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from rhcavuit01.kulnet.kuleuven.be ([134.58.240.129]:50829 "EHLO
	cavuit01.kulnet.kuleuven.be" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751847AbaJOKdb (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Oct 2014 06:33:31 -0400
In-Reply-To: <20141014135445.GA26015@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: matt.porter@linaro.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org


On 2014-10-14 15:54, Thierry Reding wrote:
> The above indicates that it would be 0x00, in which case it might be
> better to just do...
> 
> 	value &= ~(PWM_CONTROL_MASK << (PWM_CONTROL_STRIDE * pwm->hwpwm));
> 
> ... and get rid of DEFAULT_PWM_MODE.

Indeed, this has to be 0x00. PWM_CONTROL_MASK and DEFAULT_PWM_MODE are the same.
I've declared DEFAULT_PWM_MODE because they have another meaning but the values are the same. 
You can definetly use   

	value &= ~(PWM_CONTROL_MASK << (PWM_CONTROL_STRIDE * pwm->hwpwm));

Bart

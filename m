From: Florian Fainelli <fainelli@broadcom.com>
Subject: Re: [PATCH v4 0/2] pwm: Broadcom BCM7038 PWM controller (v4)
Date: Tue, 6 Oct 2015 11:16:06 -0700
Message-ID: <56140FE6.9030604@broadcom.com>
References: <1442274426-3507-1-git-send-email-f.fainelli@gmail.com> <20151005151415.GE27759@ulmo> <56140F83.2050909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:54090 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbbJFSQ1 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Oct 2015 14:16:27 -0400
In-Reply-To: <56140F83.2050909@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, ariel@vanguardiasur.com.ar

On 06/10/15 11:14, Florian Fainelli wrote:
> On 05/10/15 08:14, Thierry Reding wrote:
>> On Mon, Sep 14, 2015 at 04:47:04PM -0700, Florian Fainelli wrote:
>>> Hi,
>>>
>>> This patch series add PWM support for the Broadcom BCM7xxx
>>> chips which feature one or more PWM controllers capable of
>>> output periods from 148ns to ~622ms using a combination of
>>> variable and fixed frequency settings.
>>>
>>> The controller does not support setting a polarity.
>>>
>>> This is based on Thierry's pwm/next branch.
>>>
>>> Florian Fainelli (2):
>>>   Documentation: dt: add Broadcom BCM7038 PWM controller binding
>>>   pwm: Add Broadcom BCM7038 PWM controller support
>>
>> I've applied both of these patches with a couple of stylistic changes.
> 
> Thanks but:
> 
> 1) you dropped the MODULE_DEVICE_TABLE while doing so which is useful
> for auto-loading OF modules
> 2) you introduced a build failure in the CONFIG_PM_SLEEP
> 
> There was a patch just submitted for 2), but I can submit an incremental
> for 1) maybe?

Disregard that, brainfart on my side, was diffing branches backwards...
oh well.
-- 
Florian

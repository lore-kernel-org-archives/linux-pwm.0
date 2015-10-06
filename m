From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v4 0/2] pwm: Broadcom BCM7038 PWM controller (v4)
Date: Tue, 06 Oct 2015 11:14:27 -0700
Message-ID: <56140F83.2050909@gmail.com>
References: <1442274426-3507-1-git-send-email-f.fainelli@gmail.com> <20151005151415.GE27759@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35089 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbbJFSOs (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Oct 2015 14:14:48 -0400
In-Reply-To: <20151005151415.GE27759@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, ariel@vanguardiasur.com.ar

On 05/10/15 08:14, Thierry Reding wrote:
> On Mon, Sep 14, 2015 at 04:47:04PM -0700, Florian Fainelli wrote:
>> Hi,
>>
>> This patch series add PWM support for the Broadcom BCM7xxx
>> chips which feature one or more PWM controllers capable of
>> output periods from 148ns to ~622ms using a combination of
>> variable and fixed frequency settings.
>>
>> The controller does not support setting a polarity.
>>
>> This is based on Thierry's pwm/next branch.
>>
>> Florian Fainelli (2):
>>   Documentation: dt: add Broadcom BCM7038 PWM controller binding
>>   pwm: Add Broadcom BCM7038 PWM controller support
> 
> I've applied both of these patches with a couple of stylistic changes.

Thanks but:

1) you dropped the MODULE_DEVICE_TABLE while doing so which is useful
for auto-loading OF modules
2) you introduced a build failure in the CONFIG_PM_SLEEP

There was a patch just submitted for 2), but I can submit an incremental
for 1) maybe?
-- 
Florian

Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37358 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbfJaSmV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 31 Oct 2019 14:42:21 -0400
Date: Thu, 31 Oct 2019 11:42:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Message-ID: <20191031184214.GL57214@dtor-ws>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-3-git-send-email-jeff@labundy.com>
 <20191031134410.GB5700@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031134410.GB5700@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 2/8] mfd: Add support for Azoteq IQS620A/621/622/624/625
To: Lee Jones <lee.jones@linaro.org>
Cc: Jeff LaBundy <jeff@labundy.com>, jdelvare@suse.com, linux@roeck-us.net, thierry.reding@gmail.com, jic23@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com

On Thu, Oct 31, 2019 at 01:44:10PM +0000, Lee Jones wrote:
> On Sun, 20 Oct 2019, Jeff LaBundy wrote:
> > + * Author: Jeff LaBundy <jeff@labundy.com>
> > + *
> > + * These devices rely on application-specific register settings and calibration
> > + * data developed in and exported from a suite of GUIs offered by the vendor. A
> > + * separate tool converts the GUIs' ASCII-based output into a standard firmware
> > + * file parsed by the driver.
> 
> This troubles me somewhat. So here we take a C header file which is
> the output of a vendor supplied configuration tool, convert it to a
> bespoke file format using a Python script authored by yourself, which
> we masquerade as Linux firmware in order to set-up the hardware.
> 
> Is that correct?
> 
> What is preventing a very naughty person from providing their own
> register map (firmware) in order to read/write unsuitable registers
> from kernel context for their own gains; simply by swapping out a file
> contained in userspace?

How is it different from, let's say, Intel WiFi firmware that you load
into the kernel and then into the card every time you boot up your
laptop?

Thanks.

-- 
Dmitry

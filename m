From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] pwm: add CSR SiRFSoC PWM driver
Date: Fri, 31 Jan 2014 16:23:56 +0100
Message-ID: <201401311623.56902.arnd@arndb.de>
References: <1391061145-2078-1-git-send-email-21cnbao@gmail.com> <201401302049.27521.arnd@arndb.de> <CAGsJ_4xFKytv=Mj9eVwGY7RjyUy2W=iSXvnULKyBETYVzMVbOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53579 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499AbaAaPYI (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 31 Jan 2014 10:24:08 -0500
In-Reply-To: <CAGsJ_4xFKytv=Mj9eVwGY7RjyUy2W=iSXvnULKyBETYVzMVbOg@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rongjun Ying <Rongjun.ying@csr.com>, Huayi Li <Huayi.Li@csr.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Barry Song <Baohua.Song@csr.com>

On Friday 31 January 2014, Barry Song wrote:
> >
> > Is SRC_OSC_RATE the rate of spwm->clk? If so, it would be nice to just call
> > clk_get_rate() here, in case you ever have a chip with a different rate.
> >
> 
> SRC_OSC_RATE is the fixed frequency of crystal oscillator, but
> spwm->clk comes from the IO bus. the design is a little strange, pwm
> channels don't use the clock of PWM controller to generate
> period/duty, but use other sources.

How about modeling  that other source as a fixed-rate clock in DT
then?

	Arnd

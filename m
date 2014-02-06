From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] pwm: add CSR SiRFSoC PWM driver
Date: Thu, 6 Feb 2014 16:27:16 +0100
Message-ID: <201402061627.17086.arnd@arndb.de>
References: <1391061145-2078-1-git-send-email-21cnbao@gmail.com> <201401311623.56902.arnd@arndb.de> <CAGsJ_4xmtt2Pg_mHJmvt9uc3Y4gN7KUT1UOJhbr6FQYdiAH3qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61336 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbaBFP1Y (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Feb 2014 10:27:24 -0500
In-Reply-To: <CAGsJ_4xmtt2Pg_mHJmvt9uc3Y4gN7KUT1UOJhbr6FQYdiAH3qw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rongjun Ying <Rongjun.ying@csr.com>, Huayi Li <Huayi.Li@csr.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Barry Song <Baohua.Song@csr.com>

On Thursday 06 February 2014, Barry Song wrote:
> > How about modeling  that other source as a fixed-rate clock in DT
> > then?
> 
> sirfsoc clock drivers have a clock node for OSC whose index is "1".
> do you think the following is the right way to handle?
> 
> in dts, put both pwm controller clock and OSC
> 672                         pwm: pwm@b0130000 {
> 673                                 compatible = "sirf,prima2-pwm";
> 674                                 #pwm-cells = <2>;
> 675                                 reg = <0xb0130000 0x10000>;
> 676                                 clocks = <&clks 21>,  <&clks 1>;
> 677                                 clock-names = "pwmc", "osc";
> 678                         };
> 
> and in pwm-sirf.c driver, use
> clk = clk_get(dev, "osc");
> clk_get_rate(clk);
> 
> to get the rate in probe()?

Ah, if that's the right clock, it sounds great, yes.

Just make sure that the clock-names values make sense from the
point of view of the pwm node, rather than referring to the
name given in the clock provider.

	Arnd

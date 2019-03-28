From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v11 06/27] MAINTAINERS: Add myself as maintainer for
 Ingenic TCU drivers
Date: Wed, 27 Mar 2019 18:29:49 -0700
Message-ID: <fc86715bcd4a6cc7a4765e5b2975842fc0df57ad.camel@perches.com>
References: <20190327231631.15708-1-paul@crapouillou.net>
         <20190327231631.15708-7-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327231631.15708-7-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, 2019-03-28 at 00:16 +0100, Paul Cercueil wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -7665,6 +7665,15 @@ L:	linux-mtd@lists.infradead.org
>  S:	Maintained
>  F:	drivers/mtd/nand/raw/jz4780_*
>  
> +INGENIC TCU driver

trivia:

Generally the section header is all upper case and not mixed case
$ git grep -i DRIVER -- MAINTAINERS | \
  grep -v 'drivers/' | grep -v 'MAINTAINERS:[A-Z]:' | \
  grep -P -i -o 'drivers?' | \
  sort | uniq -c | sort -rn
    980 DRIVER
    181 DRIVERS
     19 driver
     12 Driver
      8 drivers
      3 Drivers

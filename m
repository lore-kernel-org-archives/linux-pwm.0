From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH v8 0/2] Imagination Technologies PWM support
Date: Fri, 30 Jan 2015 09:50:46 +0000
Message-ID: <CAL1qeaH77fJuh8fM1tKJz0bizni1sErCy=EwZTzV=EY10dX9iA@mail.gmail.com>
References: <1420826088-13113-1-git-send-email-ezequiel.garcia@imgtec.com>
	<54BE3369.9000802@imgtec.com>
	<54CA6089.50505@imgtec.com>
	<20150130091832.GA16744@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150130091832.GA16744@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>, James Hartley <james.hartley@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, vladimir_zapolskiy@mentor.com
List-Id: linux-pwm@vger.kernel.org

> Also you're making it especially difficult to build-test by not
> providing even the basic bits of your SoC support first. All even
> linux-next seems to have for the Pistachio SoC is the addition of a
> compatible string to the dw-mmc driver.
>
> I'll take the PWM driver, but I'll assume that you'll eventually have
> more pieces available, in which case I'd appreciate a note so I can
> update my build scripts.

FYI, I'm hoping to post Pistachio platform support for 3.21.

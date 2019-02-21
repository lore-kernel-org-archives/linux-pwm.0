From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 3/3] pwm: hibvt: Add hi3559v100 support
Date: Thu, 21 Feb 2019 20:56:41 +0100
Message-ID: <20190221195641.hqvjxixhj7fi4gff@pengutronix.de>
References: <20190219095808.12059-1-m.othacehe@gmail.com>
 <20190219095808.12059-3-m.othacehe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190219095808.12059-3-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Feb 19, 2019 at 10:58:08AM +0100, Mathieu Othacehe wrote:
> Add support for hi3559v100-shub-pwm and hisilicon,hi3559v100-pwm
> platforms. They require a special quirk: pwm has to be enabled again
> to force duty_cycle refresh.

The patch looks fine now. (If you have to do another round:
s/again/twice/ in the commit log and s/once more/twice/ in the comment
below.)

I wonder if this behaviour is a bug or a feature of the hardware. Is
this additional enable needed to apply changes to both period and
duty_cycle atomically? Is the 2nd enable needed independent of the PWM
already running? Can you share the relevant part of the documentation
without violating an NDA?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

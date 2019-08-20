From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 2/10] pwm: mediatek: droping the check for
 of_device_get_match_data
Date: Tue, 20 Aug 2019 07:40:57 +0200
Message-ID: <20190820054057.xtbhtjm65f6rphcg@pengutronix.de>
References: <1566265225-27452-1-git-send-email-sam.shih@mediatek.com>
 <1566265225-27452-3-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1566265225-27452-3-git-send-email-sam.shih@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Shih <sam.shih@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello,

On Tue, Aug 20, 2019 at 09:40:17AM +0800, Sam Shih wrote:
> From: sam shih <sam.shih@mediatek.com>

Your Signed-off-by and the mail's From uses capital letters. Can you
please make them all match?

> This patch drop the check for of_device_get_match_data.
> Due to the only way call driver probe is compatible match,
> In this case, the platform data should never be NULL.

Yeah, all entries in the of_match_table have a .data pointer.
Theoretically the driver could be bound by driver.name and then
of_device_get_match_data returns NULL.

It's still ok to drop this check if you want to, I just want to make
sure this possibility is known.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

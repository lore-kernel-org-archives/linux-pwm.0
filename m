From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 12/13] pwm: mediatek: remove a property "has-clock"
Date: Sat, 24 Aug 2019 02:41:51 +0200
Message-ID: <20190824004151.vitjflxsexlazdzy@pengutronix.de>
References: <1566457123-20791-1-git-send-email-sam.shih@mediatek.com>
 <1566457123-20791-13-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1566457123-20791-13-git-send-email-sam.shih@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Shih <sam.shih@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Aug 22, 2019 at 02:58:42PM +0800, Sam Shih wrote:
> Due to we added clock-frequency property to fix
> mt7628 pwm during configure from userspace.
> We can alos use this property to determine whether
> the complex clock tree exists in the SoC or not.
> So we can safety remove has-clock property in the
> driver specific data.

Some suggestions in short form:

s/Due/Since/
s/alos/also/

Also please use more horizontal space, up to 76 chars per line is fine.

Other than that I suggest to first address the feedback for the earlier
patches as the needed changes there has influence on this patch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

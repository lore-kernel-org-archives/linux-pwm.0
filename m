From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] pwm: bcm7038: fix check of error code returned by
 devm_ioremap_resource()
Date: Sun, 6 Mar 2016 17:15:52 -0800
Message-ID: <56DCD648.5000600@gmail.com>
References: <1457227306-3142-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ob0-f193.google.com ([209.85.214.193]:33643 "EHLO
	mail-ob0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbcCGBPz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 6 Mar 2016 20:15:55 -0500
Received: by mail-ob0-f193.google.com with SMTP id hc1so7628817obb.0
        for <linux-pwm@vger.kernel.org>; Sun, 06 Mar 2016 17:15:54 -0800 (PST)
In-Reply-To: <1457227306-3142-1-git-send-email-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com

Le 05/03/2016 17:21, Vladimir Zapolskiy a =C3=A9crit :
> The change fixes potential oops while accessing iomem on invalid
> address, if devm_ioremap_resource() fails due to some reason.
>=20
> The devm_ioremap_resource() function returns ERR_PTR() and never
> returns NULL, which makes useless a following check for NULL.
>=20
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Fixes: 3a9f5957020f ("pwm: Add Broadcom BCM7038 PWM controller suppor=
t")

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Using pwm: brcmstb for the subject might be a better fit to match the
filename, but this is bike shedding.
--=20
=46lorian

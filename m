From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Convert imx pwm to json-schema
Date: Wed, 27 May 2020 20:47:37 -0600
Message-ID: <20200528024737.GA3268948@bogus>
References: <1589439259-28510-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:37234 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1Crj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 27 May 2020 22:47:39 -0400
Content-Disposition: inline
In-Reply-To: <1589439259-28510-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: p.zabel@pengutronix.de, thierry.reding@gmail.com, shawnguo@kernel.org, linux-pwm@vger.kernel.org, robh+dt@kernel.org, festevam@gmail.com, Linux-imx@nxp.com, linux-kernel@vger.kernel.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org, kernel@pengutronix.de

On Thu, 14 May 2020 14:54:18 +0800, Anson Huang wrote:
> Convert the imx pwm binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt  | 27 ---------
>  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 66 ++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/imx-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> 

Applied, thanks!
